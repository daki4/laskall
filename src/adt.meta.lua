---@meta

---Creates a new Algebraic Data Type (ADT) factory.
---Similar to Rust's enum implementation, but for Lua.
---Creates a base type that can be extended with variants through Register()
---and whose instances are created through AdtCtor().
---@param typename string The name of the ADT type
---@return { 
---  name: string,
---  baseState: { [string]: function }, 
---  states: VariantDef[],
---  Register: fun(self: table, func: function, name: string, takesValue: boolean): nil,
---  AdtCtor: fun(self: table, state: function, value: any?): table
---}
function BuildAdt(typename)
---Represents a variant definition in the ADT system
---@class VariantDef
---@field func function The constructor function for this variant
---@field name string String representation of the variant (e.g. "Some(T)", "None")
---@field takesValue boolean Whether this variant contains a value

---Base ADT class that provides algebraic data type functionality
---@class Adt
---@field protected name string The typename given to this ADT (e.g. "Option", "Result")
---@field protected baseState { [string]: function } Table containing methods that will be available to all variants
---@field protected states VariantDef[] Array of registered variants



local Adt={}

---Internal helper to check if a variant exists in states
---@param states VariantDef[] The array of variant definitions
---@param case function The variant constructor to look for
---@return boolean true if the variant exists
local function containsCase(states, case) end

---Internal helper to deep copy a table
---@param obj table Table to copy
---@param seen table? Table of already seen references to handle cycles
---@return table Deep copy of the input table
local function copy(obj, seen) end

---Metatable for handling variant lookup in the states array
---@type { __index: fun(t: table, key: any): VariantDef? }
local funcArrMt = {
    __index = function(t, key) end
}

  return Adt
end

return BuildAdt
