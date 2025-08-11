# Vercel Deployment Guide for Evnify

## Prerequisites
1. Install Vercel CLI: `npm i -g vercel`
2. Have a Vercel account
3. MongoDB Atlas database (for production)
4. Stripe account (for payments)
5. Gmail account (for email services)

## Step 1: Deploy Backend (API)

### 1.1 Install Vercel CLI and Login
```bash
npm i -g vercel
vercel login
```

### 1.2 Deploy Backend
```bash
# From the root directory
vercel
```

### 1.3 Set Environment Variables in Vercel Dashboard
Go to your Vercel project dashboard and add these environment variables:

**Required Environment Variables:**
- `MONGODB_URI` - Your MongoDB Atlas connection string
- `JWT_SECRET` - A secure random string for JWT tokens
- `STRIPE_SECRET_KEY` - Your Stripe secret key
- `GMAIL_EMAIL` - Your Gmail address
- `GMAIL_PASSWORD` - Your Gmail app password (not regular password)
- `NODE_ENV` - Set to "production"

### 1.4 Get Your Backend URL
After deployment, note your backend URL (e.g., `https://your-app-name.vercel.app`)

## Step 2: Update Frontend Configuration

### 2.1 Update API URL
Edit `client/src/config.js` and replace `your-backend-domain.vercel.app` with your actual backend URL.

### 2.2 Deploy Frontend
```bash
cd client
vercel
```

## Step 3: Alternative - Deploy Both Together

If you want to deploy both frontend and backend together:

### 3.1 Update vercel.json
```json
{
  "version": 2,
  "builds": [
    {
      "src": "server.js",
      "use": "@vercel/node"
    },
    {
      "src": "client/package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "build"
      }
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "server.js"
    },
    {
      "src": "/(.*)",
      "dest": "client/$1"
    }
  ]
}
```

### 3.2 Deploy from Root
```bash
vercel
```

## Environment Variables Summary

Make sure to set these in your Vercel project settings:

| Variable | Description | Example |
|----------|-------------|---------|
| `MONGODB_URI` | MongoDB connection string | `mongodb+srv://username:password@cluster.mongodb.net/database` |
| `JWT_SECRET` | Secret for JWT tokens | `your-super-secret-jwt-key-here` |
| `STRIPE_SECRET_KEY` | Stripe secret key | `sk_test_...` |
| `GMAIL_EMAIL` | Gmail address | `your-email@gmail.com` |
| `GMAIL_PASSWORD` | Gmail app password | `your-app-password` |
| `NODE_ENV` | Environment | `production` |

## Important Notes

1. **MongoDB Atlas**: Make sure your MongoDB Atlas cluster allows connections from anywhere (0.0.0.0/0) or specifically from Vercel's IP ranges.

2. **Gmail App Password**: You need to generate an app password from your Google Account settings, not use your regular password.

3. **CORS**: The backend is already configured with CORS, but you might need to update it for production.

4. **File Uploads**: If you have file upload functionality, you'll need to use a service like AWS S3 or Cloudinary as Vercel's serverless functions don't support persistent file storage.

5. **Database**: Ensure your MongoDB Atlas cluster is properly configured and accessible from Vercel's servers.

## Troubleshooting

1. **API 500 Errors**: Check Vercel function logs in the dashboard
2. **CORS Issues**: Verify your frontend URL is allowed in the backend CORS configuration
3. **Database Connection**: Ensure MongoDB Atlas network access allows Vercel's IP ranges
4. **Environment Variables**: Double-check all environment variables are set correctly

## Post-Deployment

1. Test all major functionality
2. Verify email sending works
3. Test payment processing
4. Check admin and user dashboards
5. Monitor Vercel function logs for any errors
