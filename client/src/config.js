const config = {
  API_URL: process.env.NODE_ENV === 'production' 
    ? 'https://your-backend-domain.vercel.app' // Replace with your actual backend URL
    : 'http://localhost:5000'
};

export default config;
