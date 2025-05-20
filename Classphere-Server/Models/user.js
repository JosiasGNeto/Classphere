const bcrypt = require('bcrypt');
const SALT_ROUNDS = 10;
var mongoose = require('mongoose');

var userSchema = new mongoose.Schema({
    username: {type: String, unique: true},
    password: String,

    sprite: String,

    current_room: String,
    pos_x: Number,
    pos_y: Number,

    email: { type: String, required: true },
    rg: { type: String, required: true },
    nome: { type: String, required: true },
    sobrenome1: { type: String, required: true },
    sobrenome2: { type: String },
    nascimento: { type: Date, required: true },
    professor: { type: Boolean, default: false }
});

userSchema.statics.register = async function(username, email, rg, nome, sobrenome1, sobrenome2, nascimento, professor, cb) {
    try {
        const hashedPassword = await bcrypt.hash(rg, SALT_ROUNDS); // senha = hash do RG

        var new_user = new User({
            username: `${nome} ${sobrenome1 || ''}`.trim(),
            password: hashedPassword,
            email,
            rg,
            nome,
            sobrenome1,
            sobrenome2,
            nascimento: new Date(nascimento),
            professor,

            sprite: "spr_Player",
            current_room: maps[config.starting_zone].room,
            pos_x: maps[config.starting_zone].start_x,
            pos_y: maps[config.starting_zone].start_y,
        });

        await new_user.save();
        cb(true);
    } catch (err) {
        console.error("Erro no registro:", err);
        cb(false);
    }
};


userSchema.statics.login = async function(username, password, cb) {
    try {
        const user = await User.findOne({ username: username });
        if (user && await bcrypt.compare(password, user.password)) {
            cb(true, user);
        } else {
            cb(false, null);
        }
    } catch (err) {
        cb(false, null);
    }
};

module.exports = User = gamedb.model('User', userSchema);