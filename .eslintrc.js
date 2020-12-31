module.exports = {
  env: {
    browser: true,
    es6: true,
    jquery: true,
    node: true,
  },
  parser: "babel-eslint",
  extends: "eslint:recommended",
  parserOptions: {
    sourceType: "module",
    ecmaVersion: 2018
  },
  rules: {
    "indent": ["error", 2, { "ignoredNodes": ["TemplateLiteral"] }],
    "linebreak-style": ["error", "unix"],
    quotes: ["error", "double", "avoid-escape"],
    semi: ["error", "always"],
  }
};
