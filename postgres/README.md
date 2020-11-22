# PostgreSQL 


This is a Postgres database enhanced with [MADlib](https://madlib.apache.org) providing scalable machine learning capabilities and
[PostGIS](https://postgis.net/) which adds support for geographic objects. It is therefore not just for storing data but capable of advanced analytics at scale.


## Optimisation

It is possible to obtain some parameter optimisation using this online
[tool](https://pgtune.leopard.in.ua/#/). The last setting of a parameter in
`postgresql.conf` is what persists.  Simply append/amend the settings at the
end of the file and rebuild the image.


