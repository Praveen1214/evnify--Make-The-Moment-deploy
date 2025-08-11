#!/bin/bash

echo "🚀 Starting Vercel Deployment for Evnify..."

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI is not installed. Installing..."
    npm install -g vercel
fi

# Check if user is logged in to Vercel
if ! vercel whoami &> /dev/null; then
    echo "🔐 Please login to Vercel..."
    vercel login
fi

echo "📦 Installing dependencies..."
npm install
cd client && npm install && cd ..

echo "🏗️ Building the application..."
cd client && npm run build && cd ..

echo "🚀 Deploying to Vercel..."
vercel --prod

echo "✅ Deployment completed!"
echo "📝 Don't forget to set up your environment variables in the Vercel dashboard:"
echo "   - MONGODB_URI"
echo "   - JWT_SECRET"
echo "   - STRIPE_SECRET_KEY"
echo "   - GMAIL_EMAIL"
echo "   - GMAIL_PASSWORD"
echo "   - NODE_ENV=production"
