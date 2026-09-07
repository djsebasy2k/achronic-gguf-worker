# Imagen custom del worker-comfyui con el nodo ComfyUI-GGUF (city96).
# Para la ruta BARATA: Qwen cuantizado (~13GB) en GPUs de 24GB (4090).
FROM runpod/worker-comfyui:5.10.0-base

# Instalar el nodo ComfyUI-GGUF via git clone (mas confiable que comfy-node-install,
# que depende del nombre exacto del Comfy Registry).
RUN cd /comfyui/custom_nodes \
    && git clone --depth 1 https://github.com/city96/ComfyUI-GGUF.git \
    && cd ComfyUI-GGUF \
    && uv pip install -r requirements.txt || true

# Smoke test: arrancar ComfyUI en CPU para detectar import errors del nodo en el build.
RUN cd /comfyui && timeout 300 python main.py --quick-test-for-ci --cpu || true
