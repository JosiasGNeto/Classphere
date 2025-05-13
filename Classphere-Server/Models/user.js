const bcrypt = require('bcrypt');
const SALT_ROUNDS = 10;
var mongoose = require('mongoose');

var userSchema = new mongoose.Schema({
    username: {type: String, unique: true},
    password: String,

    sprite: String,

    current_room: String,
    pos_x: Number,
    pos_y: Number
});

userSchema.statics.register = async function(username, password, cb) {
    try {
        const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);

        var new_user = new User({
            username: username,
            password: hashedPassword,
            sprite: "spr_Player",
            current_room: maps[config.starting_zone].room,
            pos_x: maps[config.starting_zone].start_x,
            pos_y: maps[config.starting_zone].start_y,
        });

        await new_user.save();
        cb(true);
    } catch (err) {
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