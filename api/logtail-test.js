const { logtail } = require('./_logtail');

module.exports = async (req, res) => {
  await logtail('manual logtail test', 'info', {
    path: req.url,
    ua: req.headers['user-agent'] || '',
    ip: req.headers['x-forwarded-for'] || req.socket?.remoteAddress || '',
  });

  res.statusCode = 200;
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  res.end(JSON.stringify({ ok: true }));
};

