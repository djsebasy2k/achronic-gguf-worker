# Imagen custom del worker-comfyui con el nodo ComfyUI-GGUF (city96).
# Para la ruta BARATA: Qwen cuantizado (~13GB) en GPUs de 24GB (4090).
FROM runpod/worker-comfyui:5.10.0-base

# Clonar el nodo ComfyUI-GGUF (UnetLoaderGGUF)
RUN cd /comfyui/custom_nodes && git clone --depth 1 https://github.com/city96/ComfyUI-GGUF.git

# Dependencia del nodo. uv pip install es el patron que usa el worker-comfyui base
# (instala en /opt/venv, que es el python con el que arranca ComfyUI). Sin pin.
RUN uv pip install gguf

# Smoke test barato: confirma que gguf quedo en /opt/venv (el runtime de ComfyUI)
# y que el nodo se clono. Sin tocar gguf.__version__ (no existe en el paquete).
RUN /opt/venv/bin/python -c "import gguf; print('gguf import OK')" \
    && ls /comfyui/custom_nodes/ComfyUI-GGUF/ >/dev/null \
    && echo "GGUF node + dependency OK"
