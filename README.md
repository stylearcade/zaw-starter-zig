# zaw Starter - Zig/TypeScript

A [Zero-Allocation WASM (zaw)](https://github.com/stylearcade/zaw) starter template demonstrating SIMD-optimized XOR Int32Array operations using Zig WASM and TypeScript.

## Structure

```
├── zig/            # Zig WASM implementation with SIMD
├── typescript/     # TypeScript host with tests and benchmarks
└── package.json    # Build orchestration
```

## Quick Start

1. Install TypeScript & Zig dependencies:

```bash
npm run install
```

2. Build everything:

```bash
npm run build
```

3. Run tests:

```bash
npm test
```

4. Run benchmarks:

```bash
npm run bench
```

## Requirements

- Zig (0.14+)
- Node.js (18+)
