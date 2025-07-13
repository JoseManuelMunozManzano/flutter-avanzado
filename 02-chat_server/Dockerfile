# Imagen oficial para Node en ARM (vale para Raspberry Pi)
FROM node:20

# Crea y entra al directorio de trabajo
WORKDIR /app

# Copia package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código fuente
COPY . .

# Expone el puerto que usa tu app
EXPOSE 3000

# Comando por defecto al arrancar el contenedor
CMD ["npm", "start"]
