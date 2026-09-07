# gguf_worker — imagen serverless para la ruta BARATA (Qwen GGUF ~13GB en 24GB)

Imagen `worker-comfyui:5.10.0-base` + el nodo **ComfyUI-GGUF** (city96), para correr
`qwen-image-Q4_K_S.gguf` en GPUs de **24GB** (4090 / L4), que son las que tienen
capacidad en RunPod serverless (el pool de 48/80GB está sin stock).

## Cómo buildear y desplegar

1. Creá un repo de GitHub (público o privado) y subí esta carpeta (el `Dockerfile`
   y `.github/workflows/build.yml`).
2. GitHub Actions buildeará y subirá la imagen a `ghcr.io/<tu-usuario>/<repo>:latest`.
3. En RunPod, creá un template serverless apuntando a esa imagen de GHCR
   (o pedile al auditor que lo haga por API con ese nombre de imagen).
4. Creá/actualizá el endpoint con:
   - GPU pool: `ADA_24` (4090, 24GB) o `AMPERE_24` (L4/A5000/3090)
   - Volumen: `f2j979bw6c`
   - Modelo: `qwen-image-Q4_K_S.gguf` en `models/unet/` del volumen
5. Producí con `QWEN_GGUF=1` (el código de `runpod_cliente.py` ya tiene la rama GGUF).

## Nota

- El worker-comfyui monta el volumen en `/runpod-volume` y su `extra_model_paths.yaml`
  mapea `unet -> models/unet/`. El `.gguf` va en `models/unet/` del volumen.
- El nodo GGUF se llama `UnetLoaderGGUF` (es el que usa el código con `QWEN_GGUF=1`).
