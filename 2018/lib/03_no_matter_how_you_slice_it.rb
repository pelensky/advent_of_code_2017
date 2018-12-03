require 'utils'

class Claim

  def transform(data)
    split_data = data.split(' ')
    transformed = {}
    transformed[:id] = split_data[0][1, split_data[0].length].to_i
    transformed[:left] = split_data[2].split(',')[0].to_i
    transformed[:top] = split_data[2].split(',')[1].to_i
    transformed[:width] = split_data[3].split('x')[0].to_i
    transformed[:height] = split_data[3].split('x')[1].to_i
    transformed
  end

  def add_coordinates(claim, fabric = [])
    (claim[:top]...claim[:top] + claim[:height]).each do |y|
      (claim[:left]...claim[:left] + claim[:width]).each do |x|
        fabric << [y, x]
      end
    end
    fabric
  end

  def see_overlap(claims)
    fabric = []
    transformed_claims = transform_claims(claims)

    transformed_claims.each do |claim|
      add_coordinates(claim, fabric)
    end

    fabric.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
    # fabric.select{|v| fabric.count(v) > 1}.uniq
  end

  def count_overlap(claims)
    see_overlap(claims).length
  end

  def see_how_much_fabric_overlaps(filename)
    claims = Utils.read_words_from_file(filename)
    count_overlap(claims)
  end

  private

  def transform_claims(claims)
    claims.map { |claim| transform(claim) }
  end
end
