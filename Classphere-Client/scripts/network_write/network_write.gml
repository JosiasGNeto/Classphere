//argument0: socket
//argument1: buffer of data base to send

//Initialize

function network_write(argument0, argument1) {
    var packetSize = buffer_tell(argument1);
    var bufPacket = buffer_create(1, buffer_grow, 1);

    // Write the size and the packet
    buffer_write(bufPacket, buffer_u8, packetSize + 1);
    buffer_copy(argument1, 0, packetSize, bufPacket, 1);
    buffer_seek(bufPacket, 0, packetSize + 1);

    // Send the packet
    network_send_raw(argument0, bufPacket, buffer_tell(bufPacket));

    // Destroy the buffers
    buffer_delete(argument1);
    buffer_delete(bufPacket);
}
