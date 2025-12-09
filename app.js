const express = require("express");
const app = express();
const PORT = process.env.PORT || 8000;

app.set("trust proxy", true);

app.get("/", (req, res) => {
  const timestamp = new Date().toISOString();

  // Extract IP (best guess at public IPv4)
  let ip =
    req.headers["x-forwarded-for"]?.split(",")[0].trim() ||
    req.socket.remoteAddress ||
    req.ip ||
    "unknown";

  ip = ip.replace(/^::ffff:/, "");
  res.json({
    timestamp,
    ip
  });
});

app.listen(PORT, () => {
  console.log(`SimpleTimeService listening on port ${PORT}`);
});




