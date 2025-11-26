function interpolated = interpolation(field, thisFace)
% Harmonic interpolation

    owner = thisFace.owner;
    neighbour = thisFace.neighbour;

    d_ON = norm(thisFace.neighbour.centre - thisFace.owner.centre);
    d_Of = norm(thisFace.centre - thisFace.owner.centre);
    d_Nf = norm(thisFace.centre - thisFace.neighbour.centre);

    interpolated = d_ON/((d_Of/field(owner.id)) + (d_Nf/field(neighbour.id)));

end