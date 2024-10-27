function makeEntityMatrix(entity) {
    const [f, r, u, a] = GetEntityMatrix(entity);

    return new Float32Array([
        r[0], r[1], r[2], 0,
        f[0], f[1], f[2], 0,
        u[0], u[1], u[2], 0,
        a[0], a[1], a[2], 1,
    ]);
}

function drawEntityGizmo(entity) {
    const [f, r, u, a] = GetEntityMatrix(entity);
    let mat = new Float32Array([
        r[0], r[1], r[2], 0,
        f[0], f[1], f[2], 0,
        u[0], u[1], u[2], 0,
        a[0], a[1], a[2], 1,
    ]);
    const changed = DrawGizmo(mat, 'Editor1');
    if (changed) {
        return [mat[0], mat[1], mat[2], mat[3], mat[4], mat[5], mat[6], mat[7], mat[8], mat[9], mat[10], mat[11], mat[12], mat[13], mat[14]]
    }
}
exports('drawEntityGizmo', drawEntityGizmo);