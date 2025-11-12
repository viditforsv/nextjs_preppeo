// eslint.config.js
import js from "@eslint/js";
import globals from "globals";
import tseslint from "typescript-eslint";
import pluginReact from "eslint-plugin-react";
import pluginUnusedImports from "eslint-plugin-unused-imports";
import { defineConfig } from "eslint/config";

export default defineConfig([
  {
    files: ["**/*.{js,mjs,cjs,ts,mts,cts,jsx,tsx}"],
    languageOptions: {
      globals: globals.browser,
    },
    plugins: {
      react: pluginReact,
      "unused-imports": pluginUnusedImports,
    },
    extends: [
      js.configs.recommended,
      ...tseslint.configs.recommended,
      pluginReact.configs.flat.recommended,
    ],
    rules: {
      // ✅ Automatically remove unused imports
      "unused-imports/no-unused-imports": "error",

      // ✅ Warn for unused variables (ignore ones starting with _)
      "unused-imports/no-unused-vars": [
        "warn",
        {
          vars: "all",
          varsIgnorePattern: "^_",
          args: "after-used",
          argsIgnorePattern: "^_",
        },
      ],

      // ✅ Optional: quiet down some common React/TS rules
      "react/react-in-jsx-scope": "off",
      "@typescript-eslint/no-explicit-any": "warn", // Change to 'off' if you prefer
      "@typescript-eslint/no-unused-vars": "off", // We’re replacing this with unused-imports
    },
  },
]);
