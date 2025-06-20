const {v4: uuidV4} = require('uuid');

class Band {

  // Siempre debería tener nombre.
  constructor(name = 'no-name') {
    this.id = uuidV4(); // identificador único
    this.name = name;
    this.votes = 0;
  }
}

// Exportación por defecto.
module.exports = Band;