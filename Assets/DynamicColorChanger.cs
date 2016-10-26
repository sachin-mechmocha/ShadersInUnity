using UnityEngine;
using System.Collections;

public class DynamicColorChanger : MonoBehaviour {

	Material Mat;
	public Color[] DiscoColors;

	// Use this for initialization
	void Start () {
		Mat = GetComponent<SpriteRenderer> ().material;
		StartCoroutine("MoveColor");
	}

	IEnumerator MoveColor () {
		while (true) {
			int ind = Random.Range (0, DiscoColors.Length);
			Mat.SetColor ("_ReplaceColor", DiscoColors[ind]);
			yield return null;
		}
	}
}
