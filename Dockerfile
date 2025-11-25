
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8


WORKDIR /home/jovyan/work


COPY conda-linux-64.lock /tmp/conda-linux-64.lock

USER root
RUN conda config --set channel_priority strict && \
    mamba update -y --quiet --file /tmp/conda-linux-64.lock && \
    conda clean -afy && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
USER ${NB_UID}