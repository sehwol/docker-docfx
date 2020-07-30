FROM mono:latest

RUN set -ex; \
    \
    apt-get update; \
    apt-get -y --no-install-recommends install unzip; \
    \
    curl -sSL --output docfx.zip https://github.com/dotnet/docfx/releases/download/v2.43.5/docfx.zip; \
    echo "a05cc025382f46d13605a279ad3ae00339af32b486b264c23d41fff4b995d787 *docfx.zip" | sha256sum --check --strict -; \
    \
    mkdir -p /opt/docfx; \
    unzip docfx.zip -d /opt/docfx; \
    \
    echo '#!/bin/bash\nmono /opt/docfx/docfx.exe $@' > /usr/bin/docfx; \
    chmod +x /usr/bin/docfx; \
    rm docfx.zip

CMD ["docfx", "-h"]