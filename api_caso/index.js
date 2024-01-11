// importar las librerias para conectarme a mongo y levantar el servidor
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// Conéctate a MongoDB
mongoose.connect('mongodb://localhost:27017/usuarios', { useNewUrlParser: true, useUnifiedTopology: true });
const db = mongoose.connection;

db.on('error', console.error.bind(console, 'Error de conexión a MongoDB:'));
db.once('open', () => {
  console.log('Conexión exitosa a MongoDB');
});

// Definir el esquema del usuario
const userSchema = new mongoose.Schema({
  username: String,
  password: String,
});

const User = mongoose.model('User', userSchema);

// Middleware para parsear json
app.use(express.json());


// Ruta de registro de usuario
app.post('/register', async (req, res) => {
  try {
    const { username, password } = req.body;

    const newUser = new User({ username, password });
    await newUser.save();

    res.status(201).json({ message: 'Usuario registrado exitosamente' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
});

// Ruta de login de usuario
app.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    // Buscar el usuario en la base de datos
    const user = await User.findOne({ username });

    if (!user) {
      return res.status(401).json({ message: 'Usuario no encontrado' });
    }

    // Comparar la contraseña proporcionada con la almacenada en la base de datos
    if (password !== user.password) {
      return res.status(401).json({ message: 'Contraseña incorrecta' });
    }

    res.status(200).json({ message: 'Login exitoso' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
});

app.get('/', async (req, res) => {
    res.status(200).json({ message: 'Servidor conectado' });
});

// Iniciar el servidor
app.listen(PORT, () => {
    console.log(`Servidor en ejecución en http://localhost:${PORT}`);
  });
  