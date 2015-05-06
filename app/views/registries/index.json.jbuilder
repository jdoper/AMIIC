json.array!(@registries) do |registry|
  json.extract! registry, :id, :nome, :idade, :data, :sexo, :registro, :tipoInsuficiencia, :etiologia, :classFuncional, :FEVE, :tempoUsado, :score, :serial
  json.url registry_url(registry, format: :json)
end
