FROM mono:latest

RUN set -ex \
    \
    && apt-get update \
    && apt-get -y --no-install-recommends install unzip \
    && curl -sSL --output docfx.zip https://github.com/dotnet/docfx/releases/download/v2.56.2/docfx.zip \
    && echo "1793370064de9bcc898953d77c9eb0ea62d1ed0d5e136d3c4ac30f4d7a90de64 *docfx.zip" | sha256sum --check --strict -; \
    && mkdir -p /opt/docfx \
    && unzip docfx.zip -d /opt/docfx \
    && echo '#!/bin/bash\nmono /opt/docfx/docfx.exe $@' > /usr/bin/docfx \
    && chmod +x /usr/bin/docfx \
    && rm docfx.zip

CMD ["docfx", "-h"]