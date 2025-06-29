# KodeDeeAI Project - Multi-Service Digital Platform

## 🚀 โครงการแพลตฟอร์มดิจิทัลหลากบริการด้วย AI

**KodeDeeAI** เป็นแพลตฟอร์ม SaaS ที่ผสมผสานความสามารถของ AI เข้ากับเครื่องมือดิจิทัลหลากหลายเพื่อช่วยธุรกิจเติบโตอย่างครบวงจร

### 🌟 บริการหลัก
- **📊 Business Analytics** - วิเคราะห์ข้อมูลธุรกิจด้วย AI
- **🎨 Creative Studio** - สร้างคอนเทนต์และโฆษณาด้วย AI
- **🌐 Website Builder** - สร้างเว็บไซต์โดยไม่ต้องเขียนโค้ด
- **📈 Ads Optimization** - เพิ่มประสิทธิภาพโฆษณาอัตโนมัติ
- **🤖 AI Automation** - ระบบอัตโนมัติขั้นสูง
- **📚 Digital Learning** - แพลตฟอร์มเรียนรู้ออนไลน์

### 🛠 เทคโนโลยี
- **Frontend**: React + Vite + TailwindCSS
- **Backend**: Node.js + Express + MongoDB
- **Payment**: Stripe Integration
- **AI**: OpenAI API Integration
- **Automation**: n8n Workflows
- **Deployment**: Netlify/Vercel Ready

## 📁 โครงสร้างโครงการ

```
kodedeeai-project/
├── webapp/
│   ├── frontend/          # React Application
│   └── backend/           # Node.js API Server
├── docs/                  # Documentation
├── scripts/               # Deployment & Utility Scripts
├── n8n-flows/            # Automation Workflows
└── README.md
```

## ⚡ เริ่มต้นใช้งาน

### 1. ติดตั้ง Dependencies
```bash
npm run install:all
```

### 2. รันระบบในโหมด Development
```bash
npm run dev
```

### 3. Build สำหรับ Production
```bash
npm run build
```

### 4. รันเซิร์ฟเวอร์ Production
```bash
npm start
```

## 🔧 คำสั่งที่สำคัญ

| คำสั่ง | คำอธิบาย |
|--------|----------|
| `npm run dev` | รันระบบในโหมดพัฒนา |
| `npm run build` | Build โปรเจ็กต์สำหรับ production |
| `npm run start` | รันเซิร์ฟเวอร์ production |
| `npm run clean` | ลบไฟล์ชั่วคราวทั้งหมด |
| `npm run reset` | รีเซ็ตและติดตั้ง dependencies ใหม่ |

## 🌐 การ Deploy

### Netlify
1. Connect GitHub repository
2. Build command: `npm run build`
3. Publish directory: `webapp/frontend/dist`

### Vercel
1. Import GitHub repository
2. Framework preset: Vite
3. Build command: `npm run build`
4. Output directory: `webapp/frontend/dist`

### VPS/Cloud Server
```bash
# Clone repository
git clone https://github.com/your-username/kodedeeai-project.git
cd kodedeeai-project

# Install dependencies
npm run install:all

# Build frontend
npm run build

# Start production server
npm start
```

## 📊 Pricing Plans

| แผน | ราคา/เดือน | คุณสมบัติ |
|-----|------------|----------|
| **Starter** | ฟรี | บริการพื้นฐาน |
| **Pro** | ฿299 | บริการครบครัน + AI |
| **Enterprise** | ฿799 | ไม่จำกัด + Support |

## 🔐 Environment Variables

สร้างไฟล์ `.env` ใน `webapp/backend/`:

```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/kodedeeai
JWT_SECRET=your-secret-key
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...
OPENAI_API_KEY=sk-...
NODE_ENV=production
```

## 🤝 การพัฒนา

### Git Workflow
```bash
# สร้าง branch ใหม่
git checkout -b feature/new-feature

# Commit changes
git add .
git commit -m "Add new feature"

# Push และสร้าง PR
git push origin feature/new-feature
```

### Code Style
- ใช้ Prettier สำหรับ formatting
- ใช้ ESLint สำหรับ code quality
- ตั้งชื่อ component เป็น PascalCase
- ตั้งชื่อไฟล์เป็น kebab-case

## 📝 Documentation

- [BEGINNER-DEPLOYMENT-GUIDE.md](docs/BEGINNER-DEPLOYMENT-GUIDE.md)
- [API-DOCUMENTATION.md](docs/API-DOCUMENTATION.md)
- [PAYMENT-SYSTEM-GUIDE.md](docs/PAYMENT-SYSTEM-GUIDE.md)
- [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

## 🚀 Lovable.dev Integration

โครงการนี้พร้อมสำหรับการใช้งานกับ Lovable.dev:

1. เชื่อมต่อ GitHub repository
2. Import n8n workflows จากโฟลเดอร์ `n8n-flows/`
3. ใช้ Lovable AI สำหรับพัฒนา UI/UX

## 📞 Support

- **Email**: support@kodedeeai.com
- **Discord**: [เข้าร่วม Community](https://discord.gg/kodedeeai)
- **Documentation**: [docs.kodedeeai.com](https://docs.kodedeeai.com)

## 📄 License

MIT License - ดู [LICENSE](LICENSE) สำหรับรายละเอียด

---

🇹🇭 **Made with ❤️ in Thailand** 🇹🇭

*Transform your business with AI-powered digital solutions*
