# Imagen custom del worker-comfyui con el nodo ComfyUI-GGUF (city96).
# Para la ruta BARATA: Qwen cuantizado (~13GB) en GPUs de 24GB (4090).
FROM runpod/worker-comfyui:5.10.0-base

# Instalar el nodo ComfyUI-GGUF (UnetLoaderGGUF)
RUN comfy-node-install ComfyUI-GGUF
