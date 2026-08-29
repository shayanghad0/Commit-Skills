# Ai-list.md — AI Model Git Identity Registry

This file is read by the `/commitskillsh` skill during `commit with ai {name}` mode.
Each row defines the git `user.name` and `user.email` to use when committing under that AI model's identity.

---

## How to use

```
commit with ai deepseek
commit with ai deepseek-r1
commit with ai deepseek-v3
commit with ai deepseek-coder
```

The skill matches the `{name}` you type against the **Model ID** column (case-insensitive).

---

## DeepSeek — All Models

All DeepSeek models share the same git provider identity:

| Provider | Email | Name |
|----------|-------|------|
| DeepSeek (all models) | deepseekcustmgithub@atomicmail.io | DeepSeek |

---

## Model Registry

### V4 Series (Latest — 2026)

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `deepseek-v4-pro` | DeepSeek V4 Pro | V4 | General — frontier, 1M context |
| `deepseek-v4-flash` | DeepSeek V4 Flash | V4 | General — fast & efficient, 1M context |
| `deepseek-v4-flash-vision` | DeepSeek V4 Flash Vision Exp | V4 | Multimodal — vision + language (experimental) |

### V3 Series

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `deepseek-v3` | DeepSeek V3 | V3 | General — 671B MoE, 160K context |
| `deepseek-v3-1` | DeepSeek V3.1 | V3 | General — updated V3, 160K context |
| `deepseek-v3-0324` | DeepSeek V3-0324 | V3 | General — March 2025 checkpoint |

### R1 Series — Reasoning Models

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `deepseek-r1` | DeepSeek R1 671B | R1 | Reasoning — full flagship, 671B |
| `deepseek-r1-70b` | DeepSeek R1 Distill Llama 70B | R1 Distill | Reasoning — Llama 3.3 backbone |
| `deepseek-r1-32b` | DeepSeek R1 Distill Qwen 32B | R1 Distill | Reasoning — best single-GPU balance |
| `deepseek-r1-14b` | DeepSeek R1 Distill Qwen 14B | R1 Distill | Reasoning — 16GB VRAM |
| `deepseek-r1-8b` | DeepSeek R1 Distill Qwen3 8B (0528) | R1 Distill | Reasoning — latest small, 8GB VRAM |
| `deepseek-r1-7b` | DeepSeek R1 Distill Qwen 7B | R1 Distill | Reasoning — 8GB VRAM |
| `deepseek-r1-1.5b` | DeepSeek R1 Distill Qwen 1.5B | R1 Distill | Reasoning — CPU-capable, smallest |

### Coder Series — Code Models

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `deepseek-coder-v2` | DeepSeek Coder V2 236B MoE | Coder V2 | Code — flagship, 338 languages |
| `deepseek-coder-v2-lite` | DeepSeek Coder V2 Lite 16B | Coder V2 | Code — lightweight, single GPU |
| `deepseek-coder-33b` | DeepSeek Coder V1 33B | Coder V1 | Code — large, FIM support |
| `deepseek-coder-6.7b` | DeepSeek Coder V1 6.7B | Coder V1 | Code — compact, FIM support |
| `deepseek-coder-1.3b` | DeepSeek Coder V1 1.3B | Coder V1 | Code — smallest coder |

### Janus Series — Multimodal Models

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `deepseek-janus-pro` | DeepSeek Janus Pro 7B | Janus | Multimodal — image understanding + generation |
| `deepseek-janus` | DeepSeek Janus 1.3B | Janus | Multimodal — lightweight |
| `deepseek-janusflow` | DeepSeek JanusFlow 1.3B | Janus | Multimodal — flow-based generation |

### VL2 Series — Vision Language Models

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `deepseek-vl2` | DeepSeek VL2 4.5B | VL2 | Vision-Language — full, OCR & reasoning |
| `deepseek-vl2-small` | DeepSeek VL2 Small 2.8B | VL2 | Vision-Language — balanced |
| `deepseek-vl2-tiny` | DeepSeek VL2 Tiny 1.0B | VL2 | Vision-Language — edge / mobile |

### Prover Series — Math Proof Models

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `deepseek-prover-v2` | DeepSeek Prover V2 7B | Prover | Math — formal theorem proving in Lean 4 |

---

## Mimo AI — All Models

All Mimo AI models share the same git provider identity:

| Provider | Email | Name |
|----------|-------|------|
| Mimo AI (all models) | mimoai@atomicmail.io | Mimo Ai |

### V2.5 Series (Latest — 2026)

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `mimo-v2.5-pro` | MiMo-V2.5-Pro | V2.5 | General — frontier, 1T params |
| `mimo-v2.5-pro-base` | MiMo-V2.5-Pro-Base | V2.5 | General — 1T params, base |
| `mimo-v2.5` | MiMo-V2.5 | V2.5 | General — 311B params |
| `mimo-v2.5-base` | MiMo-V2.5-Base | V2.5 | General — 311B params, base |
| `mimo-v2.5-dflash` | MiMo-V2.5-DFlash | V2.5 | General — 311B params, draft |

### V2-Flash Series

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `mimo-v2-flash` | MiMo-V2-Flash | V2 | General — 310B params |
| `mimo-v2-flash-base` | MiMo-V2-Flash-Base | V2 | General — 310B params, base |

### Audio Series

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `mimo-audio-7b-instruct` | MiMo-Audio-7B-Instruct | Audio | Any-to-Any — 8B params, instruct |
| `mimo-audio-7b-base` | MiMo-Audio-7B-Base | Audio | Any-to-Any — 8B params, base |
| `mimo-audio-tokenizer` | MiMo-Audio-Tokenizer | Audio | Audio — 1B params, tokenizer |

---

## Quick Lookup Table (for the skill)

When the user types `commit with ai {name}`, match `{name}` against **Model ID** (case-insensitive, hyphens optional).

| Provider | Email | Name |
|----------|-------|------|
| DeepSeek (all models) | deepseekcustmgithub@atomicmail.io | DeepSeek |
| Mimo AI (all models) | mimoai@atomicmail.io | Mimo Ai |

---

## Adding New Models

To add a new AI provider or model, append a row to the registry with:
- A unique `Model ID` (lowercase, hyphen-separated)
- The `Full Name` of the model
- The git `Email` and git `Name` to commit as
