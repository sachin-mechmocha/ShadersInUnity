using UnityEngine;
using System.Collections;

[System.Serializable]
public class SectionColors {
	public Color[] _Colors;
}

public class Disco : MonoBehaviour {

	Material _Mat;
	public float _LenghtOfEachSection;
	public SectionColors[] _SectionColors;
	public AnimationCurve _Curve;

	// Use this for initialization
	void Start () {
		_Mat = GetComponent<SpriteRenderer>().material;
		StartCoroutine ("StartDisco");
		StartCoroutine ("StartLightFlicker");
	}

	IEnumerator StartDisco () {
		int i = 0;
		while (true) {
			if (i >= _SectionColors.Length) i = 0;
			for (int j = 0; j < _SectionColors[i]._Colors.Length; j++) {
				_Mat.SetColor("_ReplaceColor", _SectionColors[i]._Colors[j]);
				yield return new WaitForSeconds(_LenghtOfEachSection/_SectionColors[i]._Colors.Length);
			}
			i++;
		}
	}

	IEnumerator StartLightFlicker () {
		while (true) {
			float x = _Curve.Evaluate(Time.time);
			_Mat.SetFloat("_Intensity", x);
			yield return null;
		}
	}
}
