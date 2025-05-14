class AddExhibitionTypes < ActiveRecord::Migration[8.0]
  def up
    exhibition_types = [
      { name: 'Painting', description: 'Artworks created using paint on surfaces like canvas or paper.' },
      { name: 'Sculpture', description: 'Three-dimensional artworks created by shaping materials like stone, metal, or wood.' },
      { name: 'Photography', description: 'Artworks created using photographic techniques and cameras.' },
      { name: 'Installation', description: 'Large-scale, mixed-media constructions often designed for specific spaces.' },
      { name: 'Digital Art', description: 'Artworks created or manipulated using digital technology.' },
      { name: 'Printmaking', description: 'Artworks created by printing, typically on paper, using techniques like etching or lithography.' },
      { name: 'Ceramics', description: 'Artworks made from clay and other ceramic materials.' },
      { name: 'Textile Art', description: 'Artworks created using fibers, fabrics, or other textile techniques.' },
      { name: 'Performance Art', description: 'Artworks involving live performances by artists.' },
      { name: 'Mixed Media', description: 'Artworks created using a combination of different materials and techniques.' }
    ]

    exhibition_types.each do |type|
      ExhibitionType.create!(type)
    end
  end

  def down
    ExhibitionType.where(name: [
      'Painting', 'Sculpture', 'Photography', 'Installation', 'Digital Art',
      'Printmaking', 'Ceramics', 'Textile Art', 'Performance Art', 'Mixed Media'
    ]).destroy_all
  end
end
