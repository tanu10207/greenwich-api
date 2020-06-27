FROM  postgres:11.5-alpine

ENV POSTGIS_VERSION 2.5.3

# Download source postgis and extract & build tools
RUN set -ex \
    && apk add --no-cache --virtual .fetch-deps \
        ca-certificates \
        openssl \
        tar \
        autoconf \
        automake \
        g++ \
        libtool \
        libxml2-dev \
        make \
        perl \
        json-c \
    && wget -O postgis.tar.gz "https://github.com/postgis/postgis/archive/$POSTGIS_VERSION.tar.gz" \
    && mkdir -p /usr/src/postgis \
    && tar \
        --extract \
        --file postgis.tar.gz \
        --directory /usr/src/postgis \
        --strip-components 1 \
    && rm postgis.tar.gz

# Download dependencies
RUN set -ex \ 
    && wget -O geos-3.7.2.tar.gz "https://github.com/libgeos/geos/archive/3.7.2.tar.gz" \
    && mkdir -p /usr/src/geos \
    && tar --extract --file geos-3.7.2.tar.gz --directory /usr/src/geos --strip-components 1 \
    && rm geos-3.7.2.tar.gz \
    && cd /usr/src/geos \
    && ./autogen.sh \
    && ./configure \
    && make && make install \
    && cd / \
    && rm -rf /usr/src/geos
RUN set -ex \
    && wget -O sqlite3-3.30.tar.gz "https://www.sqlite.org/2019/sqlite-autoconf-3300100.tar.gz" \
    && mkdir -p /usr/src/sqlite3 \
    && tar --extract --file sqlite3-3.30.tar.gz --directory /usr/src/sqlite3 --strip-components 1 \
    && rm sqlite3-3.30.tar.gz \
    && cd /usr/src/sqlite3 \
    && ./configure \
    && make && make install \
    && cd / && rm -rf /usr/src/sqlite3
RUN set -ex \
    && wget -O proj-6.1.1.tar.gz "https://github.com/OSGeo/PROJ/archive/6.1.1.tar.gz" \
    && mkdir -p /usr/src/proj \    
    && tar --extract --file proj-6.1.1.tar.gz --directory /usr/src/proj --strip-components 1 \
    && rm proj-6.1.1.tar.gz \
    && cd /usr/src/proj \
    && ./autogen.sh \
    && ./configure \
    && make && make install \
    && cd / \
    && rm -rf /usr/src/proj
RUN set -ex \ 
    && apk add linux-headers \
    && wget -O gdal-3.0.1.tar.gz "http://download.osgeo.org/gdal/3.0.1/gdal-3.0.1.tar.gz" \
    && mkdir -p /usr/src/gdal \    
    && tar --extract --file gdal-3.0.1.tar.gz --directory /usr/src/gdal --strip-components 1 \
    && rm gdal-3.0.1.tar.gz \
    && cd /usr/src/gdal \
    && ./configure \
    && make && make install \
    && cd / \
    && rm -rf /usr/src/gdal
RUN set -ex \ 
    && cd /usr/src/postgis \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && cd / \
    && rm -rf /usr/src/postgis \
    && apk del .fetch-deps 

# COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh