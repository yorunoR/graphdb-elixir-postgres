module.exports = {
  root: true,
  env: {
    node: true
  },
  globals: {
    defineProps: 'readonly',
    defineEmits: 'readonly',
    defineExpose: 'readonly',
    withDefaults: 'readonly'
  },
  extends: [
    'plugin:import/recommended',
    'plugin:import/typescript',
    'plugin:vue/vue3-recommended',
    '@vue/standard',
    '@vue/typescript/recommended',
    'standard-with-typescript'
  ],
  parserOptions: {
    ecmaVersion: 2020,
    project: ['./tsconfig.eslint.json']
  },
  rules: {
    'import/namespace': 'off',
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'import/order': ['error', {
      'newlines-between': 'always',
      alphabetize: { order: 'asc' }
    }],
    '@typescript-eslint/consistent-type-imports': ['error', { prefer: 'type-imports' }]
  },
  overrides: [
    {
      files: [
        '**/__tests__/*.{j,t}s?(x)',
        '**/tests/unit/**/*.spec.{j,t}s?(x)'
      ],
      env: {
        jest: true
      }
    }
  ]
}
