# Deploy API Tester to Vercel

This guide shows how to deploy the API Tester feature on your forked branch to Vercel.

## Prerequisites

1. **Database**: You need a PostgreSQL database (Vercel Postgres, Supabase, or any PostgreSQL provider)
2. **Vercel Account**: Sign up at https://vercel.com
3. **GitHub Repository**: Your forked repo with the branch pushed

## Method 1: Vercel Dashboard (Easiest)

### Step 1: Import Project

1. Go to https://vercel.com/dashboard
2. Click **"Add New..."** → **"Project"**
3. Import your repository: `jyotipravatiitm/MacroGraph`
4. Click **"Import"**

### Step 2: Configure Project

1. **Root Directory**: `apps/web`
2. **Framework Preset**: SolidStart (should be auto-detected)
3. **Build Command**: `pnpm build` (auto-detected)
4. **Output Directory**: `.output/public` (auto-detected)

### Step 3: Set Environment Variables

Click **"Environment Variables"** and add:

**Required:**
```env
DATABASE_URL=postgresql://user:password@host:5432/database
AUTH_SECRET=your-random-secret-key-here
```

**Optional (for OAuth):**
```env
TWITCH_CLIENT_ID=your_twitch_client_id
TWITCH_CLIENT_SECRET=your_twitch_client_secret
DISCORD_CLIENT_ID=your_discord_client_id
DISCORD_CLIENT_SECRET=your_discord_client_secret
SPOTIFY_CLIENT_ID=your_spotify_client_id
SPOTIFY_CLIENT_SECRET=your_spotify_client_secret
GITHUB_CLIENT_ID=your_github_client_id
GITHUB_CLIENT_SECRET=your_github_client_secret
```

**For Server Authentication:**
```env
JWT_PRIVATE_KEY=your_rsa_private_key
```

### Step 4: Deploy Specific Branch

1. In project settings → **Git**
2. Set **Production Branch** to: `claude/api-calls-logging-01MLHcwxS9eGGQEmqK3foRKC`
3. Or create a **Preview Deployment** for this branch

### Step 5: Run Database Migrations

After first deployment:

```bash
# Using Vercel CLI (install first: npm i -g vercel)
vercel env pull
pnpm db:push
```

Or manually connect to your database and run the schema.

---

## Method 2: Vercel CLI

### Step 1: Install Vercel CLI

```bash
npm i -g vercel
# or
pnpm add -g vercel
```

### Step 2: Login

```bash
vercel login
```

### Step 3: Deploy

```bash
cd /home/user/MacroGraph/apps/web

# For preview deployment (recommended for testing)
vercel

# For production deployment
vercel --prod
```

### Step 4: Set Environment Variables

```bash
# Set required variables
vercel env add DATABASE_URL
vercel env add AUTH_SECRET

# Pull to local for migrations
vercel env pull
```

### Step 5: Run Migrations

```bash
pnpm db:push
```

---

## Method 3: GitHub Integration (Best for CI/CD)

### Step 1: Connect GitHub to Vercel

1. Go to Vercel Dashboard
2. Import your repository
3. Vercel will automatically deploy on every push

### Step 2: Configure Branch Deployments

Vercel will create:
- **Production**: From your main branch
- **Preview**: From every other branch (including your API tester branch)

### Step 3: Access Preview Deployment

Every push to `claude/api-calls-logging-01MLHcwxS9eGGQEmqK3foRKC` creates a preview URL:
```
https://your-project-git-claude-api-calls-logging-username.vercel.app
```

---

## Database Setup

### Option 1: Vercel Postgres (Easiest)

1. Go to your Vercel project
2. Click **"Storage"** tab
3. Click **"Create Database"** → **"Postgres"**
4. Database credentials automatically added to environment

### Option 2: Supabase

1. Create project at https://supabase.com
2. Get connection string from Settings → Database
3. Add to Vercel as `DATABASE_URL`

### Option 3: Any PostgreSQL Provider

Use connection string format:
```
postgresql://username:password@host:5432/database?sslmode=require
```

---

## Post-Deployment Setup

### 1. Run Migrations

The new tables need to be created:

**Via Vercel CLI:**
```bash
cd apps/web
vercel env pull  # Downloads .env.local
pnpm db:push     # Pushes schema to database
```

**Via Direct Connection:**
```bash
# Set DATABASE_URL locally
export DATABASE_URL="your_vercel_postgres_url"
pnpm db:push
```

### 2. Generate Auth Secret

```bash
# Generate a secure random string
openssl rand -base64 32
```

Add this as `AUTH_SECRET` in Vercel environment variables.

### 3. Test the Deployment

1. Visit your deployment URL
2. Log in or create an account
3. Navigate to `/api-tester`
4. Make a test API call

---

## Vercel Configuration

The project already has proper Vercel configuration:

**File: `apps/web/vite.config.ts`**
- Already configured with Vercel preset
- Nitro server for API routes
- Proper build output

---

## Environment Variables Reference

### Required

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://user:pass@host/db` |
| `AUTH_SECRET` | Session encryption key | Random 32-byte string |

### Optional

| Variable | Description |
|----------|-------------|
| `VERCEL_URL` | Auto-provided by Vercel |
| `AUTH_REDIRECT_PROXY_URL` | OAuth redirect handler |
| `TWITCH_CLIENT_ID` | Twitch OAuth |
| `TWITCH_CLIENT_SECRET` | Twitch OAuth |
| `DISCORD_CLIENT_ID` | Discord OAuth |
| `DISCORD_CLIENT_SECRET` | Discord OAuth |
| `SPOTIFY_CLIENT_ID` | Spotify OAuth |
| `SPOTIFY_CLIENT_SECRET` | Spotify OAuth |
| `GITHUB_CLIENT_ID` | GitHub OAuth |
| `GITHUB_CLIENT_SECRET` | GitHub OAuth |
| `PATREON_CLIENT_ID` | Patreon OAuth |
| `PATREON_CLIENT_SECRET` | Patreon OAuth |
| `JWT_PRIVATE_KEY` | RS256 private key for server auth |
| `CLOUDFLARE_API_TOKEN` | For playground KV storage |

---

## Troubleshooting

### Build Fails

**Check logs:**
```bash
vercel logs
```

**Common issues:**
- Missing environment variables
- Node version mismatch (use Node 18+)
- pnpm not configured

**Fix pnpm:**
Add to Vercel project settings → General → Build & Development Settings:
- Package Manager: `pnpm`

### Database Connection Fails

- Verify `DATABASE_URL` is set correctly
- Check SSL mode: Add `?sslmode=require` to connection string
- Ensure database accepts connections from Vercel IPs

### Migrations Not Applied

```bash
# Pull environment variables
vercel env pull .env.local

# Run migrations
pnpm db:push

# Or use Drizzle Studio to verify
pnpm db:studio
```

### API Routes 404

- Verify build completed successfully
- Check that `apps/web/src/app/api/` files are included in build
- Nitro should handle API routes automatically

---

## Keep Branch Separate

To keep this feature only on your branch:

1. **Don't merge to main**: Keep feature isolated
2. **Deploy as preview**: Use preview deployments
3. **Separate domain**: Assign custom domain to this deployment
4. **Environment separation**: Use different DATABASE_URL per branch

---

## Custom Domain for This Branch

1. Go to Vercel project → **Settings** → **Domains**
2. Add custom domain (e.g., `api-tester.yourdomain.com`)
3. Assign to branch: `claude/api-calls-logging-01MLHcwxS9eGGQEmqK3foRKC`
4. Now this branch has its own permanent URL

---

## Monitoring

### Check Logs
```bash
vercel logs [deployment-url]
```

### View Analytics
- Vercel Dashboard → Analytics
- See API call performance
- Monitor errors

### Database Logs
- Check your PostgreSQL provider's dashboard
- Monitor API call logs in `api_call_logs` table

---

## Cost Considerations

### Vercel Hobby (Free)
- 100 GB bandwidth/month
- Unlimited deployments
- Serverless functions: 100 GB-hours

### Vercel Pro ($20/month)
- 1 TB bandwidth
- More function execution time
- Team collaboration

### Database
- Vercel Postgres: ~$0.10/10k reads
- Supabase Free: 500 MB storage, 2 GB bandwidth

---

## Security Notes

1. **API Logs**: May contain sensitive data - ensure proper access control
2. **Environment Variables**: Never commit to git
3. **Database**: Use strong passwords, SSL required
4. **Authentication**: Required for all API tester endpoints

---

## Next Steps After Deployment

1. ✅ Test API tester UI at `/api-tester`
2. ✅ Create an environment with variables
3. ✅ Make test API calls
4. ✅ Create a workflow
5. ✅ Check logs in database and markdown files
6. ✅ Monitor `api-logs/` directory (in deployment, these go to `/tmp`)

---

## Questions?

- Vercel Docs: https://vercel.com/docs
- SolidStart: https://start.solidjs.com/getting-started/deployment
- Drizzle ORM: https://orm.drizzle.team/docs/overview

**Note**: The `api-logs/` markdown files work locally but in Vercel's serverless environment, they're written to `/tmp` and cleared between invocations. The database logs are persistent and recommended for production.
