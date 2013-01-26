package

{

	import org.flixel.*;

	[SWF(width="480", height="480", backgroundColor="#000000")]

	[Frame(factoryClass="Preloader")]



	public class JetpackFiasco extends FlxGame

	{

		public function JetpackFiasco()

		{
			super(240, 240, SetAndSettingsState, 2, 60, 60);
			FlxG.debug = false;
			//forceDebugger = true;
		}

	}

}

