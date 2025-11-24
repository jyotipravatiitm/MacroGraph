# 🚀 Quick Start: Deploy API Tester to Vercel

Your API Tester feature is ready to deploy! Here's the fastest way to get it running on Vercel.

## ⚡ 3-Minute Deploy

### 1. Go to Vercel Dashboard
👉 https://vercel.com/new

### 2. Import Your Repository
- Click **"Import Project"**
- Select: `jyotipravatiitm/MacroGraph`
- Click **"Import"**

### 3. Configure Settings
```
Root Directory: apps/web
Framework: SolidStart (auto-detected)
Branch: claude/api-calls-logging-01MLHcwxS9eGGQEmqK3foRKC
```

### 4. Add Environment Variables
Click "Environment Variables" and add:

```env
DATABASE_URL=postgresql://user:password@host:5432/database
AUTH_SECRET=generate-random-32-byte-string
```

**Generate AUTH_SECRET:**
```bash
openssl rand -base64 32
```

### 5. Deploy!
Click **"Deploy"** and wait ~2 minutes

---

## 📊 Database Setup (Choose One)

### Option A: Vercel Postgres (Easiest)
1. In your Vercel project → **Storage** tab
2. Click **"Create Database"** → **Postgres**
3. Done! `DATABASE_URL` auto-configured

### Option B: Supabase (Free)
1. Create project: https://supabase.com
2. Get connection string: Settings → Database
3. Add to Vercel as `DATABASE_URL`

### Option C: Any PostgreSQL
Use format:
```
postgresql://user:pass@host:5432/db?sslmode=require
```

---

## 🗃️ Run Migrations

After deployment, create the tables:

### Method 1: Using Vercel CLI
```bash
# Install CLI
npm i -g vercel

# Login
vercel login

# Pull environment
cd apps/web
vercel env pull

# Run migrations
pnpm db:push
```

### Method 2: Manual SQL
Connect to your database and run the schema from `apps/web/src/drizzle/schema.ts`

Or generate migration:
```bash
pnpm db:gen
# Then apply SQL manually
```

---

## ✅ Test Your Deployment

1. Visit your Vercel URL (e.g., `your-project.vercel.app`)
2. Create an account / Login
3. Navigate to `/api-tester`
4. Make a test API call:
   - Method: `GET`
   - URL: `https://api.github.com/users/github`
   - Click **Send**
5. ✨ You should see the response!

---

## 🔒 Keep Feature on This Branch Only

Your API Tester is isolated to branch: `claude/api-calls-logging-01MLHcwxS9eGGQEmqK3foRKC`

### Deploy as Preview
Vercel automatically creates preview URLs for non-main branches:
```
https://macrograph-git-claude-api-calls-logging-yourusername.vercel.app
```

### Or Assign Custom Domain
1. Vercel Dashboard → **Domains**
2. Add domain: `api-tester.yourdomain.com`
3. Assign to branch: `claude/api-calls-logging-01MLHcwxS9eGGQEmqK3foRKC`

This gives your feature its own permanent URL without affecting main branch!

---

## 📱 Access Your API Tester

After deployment:
- **UI**: `https://your-url.vercel.app/api-tester`
- **API Docs**: See `API_TESTER_README.md`
- **Examples**: See `api-tester-examples.ts`

### Features Available:
✅ Make HTTP requests (GET, POST, PUT, etc.)
✅ Bearer, Basic, API Key, OAuth2 auth
✅ Custom headers and payloads
✅ Environment variables with `{{variable}}`
✅ Request chaining workflows
✅ Automatic logging to database
✅ Response time tracking

---

## 🆘 Troubleshooting

### Build Fails
```bash
# Check logs
vercel logs

# Ensure pnpm is configured
# In Vercel: Settings → Build & Development
# Package Manager: pnpm
```

### Can't Connect to Database
- Verify `DATABASE_URL` is correct
- Add `?sslmode=require` if needed
- Check firewall allows Vercel IPs

### Tables Don't Exist
Run migrations:
```bash
cd apps/web
vercel env pull
pnpm db:push
```

### API Routes Return 404
- Verify build succeeded
- Check `apps/web/src/app/api/api-tester/` exists
- Nitro should auto-configure routes

---

## 💡 Pro Tips

### Use Preview Deployments
Every push to your branch creates a new preview:
```bash
git push origin claude/api-calls-logging-01MLHcwxS9eGGQEmqK3foRKC
# → Auto-deploys to preview URL
```

### Monitor Logs
```bash
vercel logs [deployment-url]
```

### Check Database Logs
All API calls are in the `api_call_logs` table:
```sql
SELECT * FROM api_call_logs
ORDER BY timestamp DESC
LIMIT 10;
```

---

## 📖 Full Documentation

- **Deployment Guide**: `VERCEL_DEPLOYMENT.md` (detailed 1500+ lines)
- **API Documentation**: `API_TESTER_README.md`
- **Code Examples**: `api-tester-examples.ts`

---

## 🎯 Next Steps

1. ✅ Deploy to Vercel
2. ✅ Run database migrations
3. ✅ Test the `/api-tester` UI
4. ✅ Create an environment with variables
5. ✅ Build your first workflow
6. ✅ Check the logs

---

**Questions?** See full guide in `VERCEL_DEPLOYMENT.md` or Vercel docs: https://vercel.com/docs
