# db/seeds.rb

service_type_names = [
  "Estética",
  "Consultas médicas",
  "Consultas veterinarias",
  "Consultas odontológicas",
  "Rehabilitación",
  "Kinesiologia"
]

service_type_names.each do |name|
  ServiceType.find_or_create_by!(name: name)
end

puts "✅ Tipos de servicio verificados: #{service_type_names.join(', ')}"

# 2️⃣ Usuario proveedor de prueba
provider = User.find_by(email: "pro@mail.com")
unless provider
  provider = User.new(
    email: "pro@mail.com",
    password: "1234",
    name: "Juan",
    last_name: "Pérez",
    address: "Calle Falsa 123",
    phone: "01123456789",
    avatar: nil,
    document_type: "DNI",
    dni: "12345678",
    jti: SecureRandom.uuid,
    role_mask: 1
  )
  # Aquí, AASM pondrá state = "created" automáticamente
  unless provider.save
    puts "⚠️ Error al guardar el usuario:"
    puts provider.errors.full_messages
    raise ActiveRecord::RecordInvalid.new(provider)
  end
end

puts "✅ Proveedor de prueba verificado: #{provider.email}"

# 3️⃣ Crear slots de prueba para ese proveedor
3.times do |i|
  slot_time = Time.zone.now + (i + 1).days + 9.hours

  slot = AppointmentSlot.find_or_initialize_by(user: provider, starting: slot_time)
  slot.duration = 60
  slot.max_requests = 1
  slot.save!
end

puts "✅ Slots de prueba creados para el proveedor."

puts "🚀 Semillas listas. ¡Base de datos preparada!"