if [ ! -d "COSC2767-RMIT-Store" ]; then
	echo "COSC2767-RMIT-Store does not exist."
	exit 1
fi




# Build image
cd COSC2767-RMIT-Store/server
echo '# Fetching the minified node image on apline linux
FROM node:slim

# Declaring env
ENV NODE_ENV development

# Setting up the work directory
WORKDIR /app

# Copying all the files in our project
COPY . .

# Installing dependencies
RUN npm install

# Starting our application
CMD [ "npm", "run", "dev" ]

# Exposing server port
EXPOSE 3000' > Dockerfile

docker build -t backend-app .





# Build image
cd COSC2767-RMIT-Store/client
echo '# Fetching the minified node image on apline linux
FROM node:slim

# Declaring env
ENV NODE_ENV development

# Setting up the work directory
WORKDIR /app

# Copying all the files in our project
COPY package*.json ./
COPY . .

# Installing dependencies
RUN npm install

# Starting our application
CMD [ "npm", "run", "dev" ]

# Exposing server port
EXPOSE 8080' > Dockerfile

docker build -t frontend-app .

exit 0