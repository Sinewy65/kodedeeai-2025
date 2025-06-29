# 🚀 Complete Deployment Guide - KodeDeeAI

## การ Deploy โครงการไปยัง Production

คู่มือฉบับสมบูรณ์สำหรับการ Deploy KodeDeeAI Multi-Service Platform

---

## 📋 Pre-Deployment Checklist

### ✅ Code Preparation
- [ ] Frontend build ได้โดยไม่มี errors
- [ ] Backend tests ผ่านทั้งหมด
- [ ] Environment variables ครบถ้วน
- [ ] Database connection ใช้งานได้
- [ ] Payment system ทดสอบแล้ว

### ✅ Infrastructure Requirements
- [ ] Domain name พร้อมใช้งาน
- [ ] SSL certificate
- [ ] Database server (MongoDB Atlas หรือ local)
- [ ] Email service (SendGrid/Gmail)
- [ ] CDN service (optional)

---

## 🌐 Option 1: Netlify Deployment (Recommended for Frontend)

### Frontend Deployment

1. **Build Frontend**
```bash
cd webapp/frontend
npm run build
```

2. **Deploy to Netlify**
   - ลาก folder `dist` ไปวางใน [netlify.com/drop](https://netlify.com/drop)
   - หรือเชื่อม GitHub repository

3. **Configure Environment Variables**
```
VITE_API_URL=https://your-api-domain.com/api
VITE_STRIPE_PUBLISHABLE_KEY=pk_live_...
VITE_APP_NAME=KodeDeeAI
```

4. **Custom Domain Setup**
   - Netlify Dashboard → Domain settings
   - Add custom domain: `app.kodedeeai.com`
   - Configure DNS records

### Backend API Deployment

#### Option A: Railway
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login and deploy
railway login
railway init
railway up
```

#### Option B: Heroku
```bash
# Install Heroku CLI
npm install -g heroku

# Create app and deploy
heroku create kodedeeai-api
git push heroku main
```

---

## 🖥 Option 2: VPS Deployment (Full Control)

### Server Setup (Ubuntu 20.04+)

1. **Initial Server Setup**
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js 18+
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2 for process management
sudo npm install -g pm2

# Install Nginx
sudo apt install nginx

# Install MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
```

2. **Deploy Application**
```bash
# Clone repository
git clone https://github.com/your-username/kodedeeai-project.git
cd kodedeeai-project

# Install dependencies
npm run install:all

# Build frontend
npm run build

# Configure environment
cp webapp/backend/.env.example webapp/backend/.env
nano webapp/backend/.env
```

3. **Environment Configuration**
```env
# webapp/backend/.env
NODE_ENV=production
PORT=3000
MONGODB_URI=mongodb://localhost:27017/kodedeeai
JWT_SECRET=your-super-secret-jwt-key
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
SENDGRID_API_KEY=SG....
FRONTEND_URL=https://app.kodedeeai.com
```

4. **Start Services with PM2**
```bash
# Start backend
cd webapp/backend
pm2 start server.js --name "kodedeeai-api"

# Save PM2 configuration
pm2 save
pm2 startup
```

5. **Configure Nginx**
```nginx
# /etc/nginx/sites-available/kodedeeai
server {
    listen 80;
    server_name api.kodedeeai.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}

server {
    listen 80;
    server_name app.kodedeeai.com;
    root /home/ubuntu/kodedeeai-project/webapp/frontend/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

6. **Enable SSL with Let's Encrypt**
```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificates
sudo certbot --nginx -d app.kodedeeai.com -d api.kodedeeai.com

# Auto-renewal
sudo systemctl enable certbot.timer
```

---

## 📊 Option 3: Docker Deployment

### Create Dockerfile

**Frontend Dockerfile**
```dockerfile
# webapp/frontend/Dockerfile
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**Backend Dockerfile**
```dockerfile
# webapp/backend/Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### Docker Compose
```yaml
# docker-compose.yml
version: '3.8'
services:
  frontend:
    build: ./webapp/frontend
    ports:
      - "80:80"
    depends_on:
      - backend

  backend:
    build: ./webapp/backend
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - MONGODB_URI=mongodb://mongo:27017/kodedeeai
    depends_on:
      - mongo

  mongo:
    image: mongo:6.0
    volumes:
      - mongodb_data:/data/db
    ports:
      - "27017:27017"

volumes:
  mongodb_data:
```

### Deploy with Docker
```bash
# Build and start services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

---

## 🔧 Post-Deployment Configuration

### 1. Database Setup
```bash
# Connect to MongoDB
mongosh

# Create admin user
use kodedeeai
db.createUser({
  user: "admin",
  pwd: "secure-password",
  roles: [{ role: "readWrite", db: "kodedeeai" }]
})

# Create indexes
db.users.createIndex({ email: 1 }, { unique: true })
db.users.createIndex({ "subscription.stripeCustomerId": 1 })
```

### 2. Payment System Setup
```bash
# Test Stripe webhooks
stripe listen --forward-to https://api.kodedeeai.com/api/payment/webhook

# Configure webhook endpoints in Stripe Dashboard
# URL: https://api.kodedeeai.com/api/payment/webhook
# Events: payment_intent.succeeded, customer.subscription.updated, etc.
```

### 3. Monitoring Setup
```bash
# Install monitoring tools
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 30

# Setup health checks
curl -f https://api.kodedeeai.com/api/health || exit 1
```

---

## 📈 Performance Optimization

### Frontend Optimization
1. **Enable Gzip compression**
2. **Configure CDN** (Cloudflare/AWS CloudFront)
3. **Optimize images** (WebP format)
4. **Enable browser caching**

### Backend Optimization
1. **Database indexing**
2. **Redis caching**
3. **API rate limiting**
4. **Connection pooling**

---

## 🔍 Monitoring & Maintenance

### Health Checks
```bash
# Create health check endpoint
# GET /api/health
{
  "status": "healthy",
  "timestamp": "2025-06-29T00:00:00Z",
  "services": {
    "database": "connected",
    "stripe": "connected",
    "email": "connected"
  }
}
```

### Backup Strategy
```bash
# Database backup
mongodump --db kodedeeai --out /backup/$(date +%Y%m%d)

# Application backup
tar -czf app-backup-$(date +%Y%m%d).tar.gz kodedeeai-project/

# Automated backup script
#!/bin/bash
# /home/ubuntu/backup.sh
DATE=$(date +%Y%m%d)
mongodump --db kodedeeai --out /backup/$DATE
find /backup -type d -mtime +7 -delete
```

### Log Management
```bash
# Nginx logs
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log

# Application logs
pm2 logs kodedeeai-api --lines 100

# System monitoring
htop
df -h
free -m
```

---

## 🚨 Troubleshooting

### Common Issues

**1. Build Failures**
```bash
# Clear cache and rebuild
rm -rf node_modules package-lock.json
npm install
npm run build
```

**2. Database Connection Issues**
```bash
# Check MongoDB status
sudo systemctl status mongod

# Restart MongoDB
sudo systemctl restart mongod
```

**3. SSL Certificate Issues**
```bash
# Renew certificates
sudo certbot renew

# Check certificate status
sudo certbot certificates
```

**4. Memory Issues**
```bash
# Check memory usage
free -m

# Restart PM2 processes
pm2 restart all
```

---

## 📞 Support & Maintenance

### Update Process
```bash
# Pull latest changes
git pull origin main

# Update dependencies
npm run install:all

# Rebuild frontend
npm run build

# Restart services
pm2 restart all
```

### Emergency Procedures
1. **Service Down**: `pm2 restart all`
2. **Database Issues**: Check MongoDB logs
3. **High Traffic**: Enable Cloudflare protection
4. **Payment Issues**: Check Stripe dashboard

---

## ✅ Deployment Success Checklist

- [ ] Frontend loads correctly
- [ ] API endpoints respond
- [ ] Database connections work
- [ ] Payment processing functional
- [ ] Email notifications sending
- [ ] SSL certificates active
- [ ] Monitoring setup
- [ ] Backup procedures tested
- [ ] Error reporting configured
- [ ] Performance optimized

---

**🎉 Congratulations! Your KodeDeeAI platform is now live and ready to serve users.**

For support, contact: support@kodedeeai.com
