# Imagen custom del worker-comfyui con el nodo ComfyUI-GGUF (city96).
# Para la ruta BARATA: Qwen cuantizado (~13GB) en GPUs de 24GB (4090).
FROM runpod/worker-comfyui:5.10.0-base

# Clonar el nodo ComfyUI-GGUF (UnetLoaderGGUF)
RUN cd /comfyui/custom_nodes && git clone --depth 1 https://github.com/city96/ComfyUI-GGUF.git

# Dependencias del nodo (gguf >= 0.13 + sentencepiece + protobuf).
# Sin || true: si falla, el build falla y se ve en GitHub Actions.
RUN uv pip install "gguf>=0.13.0" sentencepiece protobuf

# Verificar que el paquete gguf y el nodo quedaron instalados
RUN python -c "import gguf; print('gguf', gguf.__version__)" && ls /comfyui/custom_nodes/ComfyUI-GGUF/
