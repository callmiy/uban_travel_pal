const allSet = process.env.URBAN_ALL_SET;

if (!allSet) {
  throw new Error(`

  Please set environment variables!

  `);
}
