#!/bin/bash
# Quick Vercel Setup Script for API Tester

set -e

echo "🚀 MacroGraph API Tester - Vercel Setup"
echo "========================================"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: Please run this from apps/web directory"
    exit 1
fi

# Check if vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Vercel CLI not found. Installing..."
    npm install -g vercel
fi

echo "✅ Vercel CLI ready"
echo ""

# Login to Vercel
echo "🔐 Logging in to Vercel..."
vercel login

echo ""
echo "📋 Next steps:"
echo ""
echo "1. Set up environment variables:"
echo "   vercel env add DATABASE_URL"
echo "   vercel env add AUTH_SECRET"
echo ""
echo "2. Deploy your project:"
echo "   vercel          # Preview deployment"
echo "   vercel --prod   # Production deployment"
echo ""
echo "3. Pull environment variables locally:"
echo "   vercel env pull"
echo ""
echo "4. Run database migrations:"
echo "   pnpm db:push"
echo ""
echo "5. Access your deployment at the URL provided by Vercel"
echo "   Navigate to /api-tester to use the API testing tool"
echo ""
echo "📖 Full guide: See VERCEL_DEPLOYMENT.md in the project root"
