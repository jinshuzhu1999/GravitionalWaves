function fcross = formulafc(phi,theta)
 
%Fc = FORMULAFc(P,T)
%Calculate the F_x antenna pattern function of an interferometer with
%perpendicular arms using source direction specified in the detectors local
%frame in which the X and Y axes are oriented along the arms of the
%detector. T and P are scalars containing values of the polar and azimuthal
%angles, respectively, in radians. The calculation of the antenna pattern
%uses the analytical formula.



fcross = cos(theta)*sin(2*phi);
end

