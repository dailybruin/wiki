FROM requarks/wiki:1.0

WORKDIR /var/wiki

ADD ./server/controllers/auth.js server/controllers/auth.js
ADD ./server/models/user.js server/models/user.js
ADD ./assets/images/ assets/images/
ADD ./config.yml config.yml

EXPOSE 3000
ENTRYPOINT [ "node", "server" ]
