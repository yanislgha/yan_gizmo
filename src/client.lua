
local DrawGizmo = false


function IsGizmoDrawn()
    return DrawGizmo
end

function StartGizmo(entity, allowScale)
    CreateThread(function()
        if DrawGizmo then
            return
        end
        DrawGizmo = true
        local cursorMode = true
        EnterCursorMode()
        while DrawGizmo do
            if not DoesEntityExist(entity) then
                break
            end

            if cursorMode and IsControlJustPressed(0, 19) then
                cursorMode = false
                LeaveCursorMode()
            end
            if not cursorMode and IsControlJustReleased(0, 19) then
                cursorMode = true
                EnterCursorMode()
            end

            DisableControlAction(0, 24, true)
            DisableControlAction(0, 45, true)
            DisableControlAction(0, 140, true)
            local matrixBuff = exports[GetCurrentResourceName()]:drawEntityGizmo(entity)
            if matrixBuff then
                ApplyEntityMatrix(entity, matrixBuff, allowScale)
            end

            Wait(0)
        end
        DrawGizmo = false
        LeaveCursorMode()
    end)
end

exports('startGizmo', StartGizmo)

function StopGizmo()
    DrawGizmo = false
end

function ApplyEntityMatrix(entity, mat, allowScale)
    local right = vector3(mat[5], mat[6], mat[7])
    local forward = vector3(mat[1], mat[2], mat[3])
    local up = vector3(mat[9], mat[10], mat[11])
    local at = vector3(mat[13], mat[14], mat[15])

    -- Force normalized vector if not allowed to scale entity
    if not allowScale then
        right = right/#right
        forward = forward/#forward
        up = up/#up
    end

    SetEntityMatrix(
        entity,
        right.x, right.y, right.z,
        forward.x, forward.y, forward.z,
        up.x, up.y, up.z,
        at.x, at.y, at.z
    )
end


RegisterKeyMapping("+gizmoSelect", "Selects the currently highlighted gizmo", "MOUSE_BUTTON", "MOUSE_LEFT")
RegisterKeyMapping("+gizmoTranslation", "Sets mode of the gizmo to translation", "keyboard", "G")
RegisterKeyMapping("+gizmoRotation", "Sets mode for the gizmo to rotation", "keyboard", "R")
RegisterKeyMapping("+gizmoScale", "Sets mode for the gizmo to scale", "keyboard", "H")
RegisterKeyMapping("+gizmoLocal", "Sets gizmo to be local to the entity instead of world", "keyboard", "L")


