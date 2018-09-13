within PlanarMechanics.Visualizers.Advanced;
model Arrow
  "Visualizing an arrow with variable size; all data have to be set as modifiers (see info layer)"

  input MB.Frames.Orientation R=MB.Frames.nullRotation()
    "Orientation object to rotate the planarWorld frame into the arrow frame" annotation(Dialog);
  input SI.Position r[3]={0,0,0}
    "Position vector from origin of planarWorld frame to origin of arrow frame, resolved in planarWorld frame"
    annotation(Dialog);
  input SI.Position r_tail[3]={0,0,0}
    "Position vector from origin of arrow frame to arrow tail, resolved in arrow frame"
    annotation(Dialog);
  input SI.Position r_head[3]={0,0,0}
    "Position vector from arrow tail to the head of the arrow, resolved in arrow frame"
    annotation(Dialog);
  input SI.Diameter diameter=planarWorld.defaultArrowDiameter
    "Diameter of arrow line" annotation(Dialog);
  input PlanarMechanics.Types.Color color=PlanarMechanics.Types.Defaults.ArrowColor
    "Color of arrow"
    annotation(HideResult=true, Dialog(colorSelector=true));
  input PlanarMechanics.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
    annotation(HideResult=true, Dialog);

protected
  outer PlanarWorld planarWorld;
  Internal.Arrow arrow(
    R=R,
    r=r,
    r_tail=r_tail,
    r_head=r_head,
    diameter=diameter,
    color=color,
    specularCoefficient=specularCoefficient) if planarWorld.enableAnimation;
  annotation (
    Documentation(info="<html>
<p>
Model <b>Arrow</b> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
</p>

<p>
The variables under heading <b>Parameters</b> below
are declared as (time varying) <b>input</b> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <b>Arrow</b> instance is used, e.g., in the form
</p>
<blockquote><pre>
Visualizers.Advanced.Arrow arrow(diameter = sin(time));
</pre></blockquote>

<p>
Variable <b>color</b> is a RGB color space given in the range 0 .. 255.
The predefined type <a href=\"modelica://PlanarMechanics.Types.Color\">Types.Color</a>
contains a menu definition of the colors used in the library</a>
(will be replaced by a color editor).
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,30},{20,-30}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,60},{100,0},{20,-60},{20,60}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          lineColor={0,0,255})}));
end Arrow;
