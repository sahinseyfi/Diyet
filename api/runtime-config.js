// Vercel Serverless Function: runtime config for client (public-safe values)
module.exports = (req, res) => {
  const dsn = process.env.SENTRY_DSN || ""; // Public DSN can be exposed to client
  const environment = process.env.VERCEL_ENV || "development";
  const release = process.env.VERCEL_GIT_COMMIT_SHA || "";

  res.statusCode = 200;
  res.setHeader("Content-Type", "application/json; charset=utf-8");
  res.end(
    JSON.stringify({
      sentryDsn: dsn,
      environment,
      release,
    })
  );
};

