const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello from EC2! Your pipeline is working. all done final step jenkins');
});

// Export for testing, but only listen if not in a test environment
if (require.main === module) {
  app.listen(80, () => {
    console.log(`Server running at http://localhost:${port}`);
  });
}

module.exports = app;