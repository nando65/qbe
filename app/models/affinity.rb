class Affinity < ActiveRecord::Base

  has_many :follows

def self.fill_table_affinity
  a=Affinity.new
  a.level=1
  a.affinity_description ="Aquellas personas más cercanas a tí y te conocen en profundidad. Algunas veces incluso saben tus secretos (ej. familia más cercana y mejores amigos)"
  b=Affinity.new
  b.level=2
  b.affinity_description ="Aquellas personas que son cercanas pero no compartes con ellas tanto como para conocer tus secretos (ej. primos o familiares, amigos de clases o de trabajo)"
  c=Affinity.new
  c.level =3
  c.affinity_description="Aquellas personas que siguen formando parte de tu lista de conocidos pero no te conocen en profundidad (ej. otros amigos de clases o trabajo, vecinos, familiares de tu 1º y 2º círculo)"
  a.save
  b.save
  c.save

end
end
