within PlanarMechanics.VehicleComponents;
model AirResistanceLongitudinal "Velocity dependent longitudinal air resistance"

  parameter Real c_W(min=0) = 0.5 "Drag coefficient";
  parameter SI.Area area(min=0) = 1.2 "Frontal cross area of vehicle";
  parameter SI.Density rho = 1.18 "Air density";

  SI.Velocity vAir[2]
    "Air velocity relative to vehicle (vAir = -v_veh + v_wind), resolved in frame_a";
  SI.Force fDrag "Scalar drag force";

protected
  SI.Force f_long "Air force acting in x-direction of frame_a, resolved in frame_a";
  SI.Velocity v_wind_0[2] "Wind velocity, resolved in inertial system";
  SI.Velocity v0[2] "Velocity resolved in inertial frame";
  constant SI.Velocity v_eps = 1e-3
    "Minimum vehicle velocity to apply this air drag model";
  Real R[2,2] "Rotation matrix";

public
  Interfaces.Frame_a frame_a annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));

equation
  // Vehicle environment
  v_wind_0=zeros(2); //atmosphere.windVelocity(frame_a.r_0);

  R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  v0 = der({frame_a.x,frame_a.y});
  //v = transpose(R)*v0;
  //v = v_long*e0;

  // Air velocity resolved in frame_a
  vAir = transpose(R)*( -v0 + v_wind_0);

  // Force and torque
  fDrag = 0.5*area*rho*vAir[1]*vAir[1]*c_W;
  f_long = noEvent(if vAir[1] > -v_eps then 0 else fDrag);
  {frame_a.fx, frame_a.fy} = R*{f_long, 0};
  frame_a.t = 0;

  annotation (
    Documentation(
      info="<html>
<p>
The vehicle&apos;s air drag, resolved in <code>frame_a</code>, is calculated as:
</p>
<blockquote><pre>
fDrag = ( c_W *  area * rho * v_x^2 ) / 2
</pre></blockquote>
<p>where: </p>
<blockquote><pre>
c_W           : air drag coefficient,
area          : cross area of vehicle,
rho           : density of the air,
v_x = vAir[1] : longitudinal component of air velocity, resolved in frame_a.
</pre></blockquote>
<p>
Just air drag in vehicle&apos;s longitudinal direction is calculated here, which
is assumed being in x-direction of <code>frame_a</code>, thus
<code>frame_a.fx&nbsp;= fDrag</code>.
The other forces and torque are disregarded.
</p>

<h4>Note</h4>
<p>
This model is limited to negative air velocity <code>v_x</code> only.
For positive velocity, which can occur e.g. when driving rearwards,
the air drag is set to zero.
</p>
</html>"),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}})),
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-96,40},{80,-40}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-60,20},{-60,-20},{-80,0},{-60,20}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Polygon(
          points={{-62,6},{-62,-6},{-60,-6},{-44,0},{-22,-10},{-6,-10},{20,0},{42,-10},{58,-10},{74,-2},{74,-2},{74,10},{74,10},{50,0},{28,10},{12,10},{-14,0},{-38,10},{-50,10},{-60,6},{-62,6}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Text(
          extent={{-100,-30},{100,-60}},
          lineColor={0,0,0},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid,
          textString="cw = %c_W"),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255})}));
end AirResistanceLongitudinal;
