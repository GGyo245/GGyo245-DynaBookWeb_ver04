package kr.co.novelweb.service;

import com.ibm.cloud.sdk.core.security.IamAuthenticator;
import com.ibm.watson.natural_language_understanding.v1.NaturalLanguageUnderstanding;
import com.ibm.watson.natural_language_understanding.v1.model.AnalysisResults;
import com.ibm.watson.natural_language_understanding.v1.model.AnalyzeOptions;
import com.ibm.watson.natural_language_understanding.v1.model.EmotionOptions;
import com.ibm.watson.natural_language_understanding.v1.model.EmotionResult;
import com.ibm.watson.natural_language_understanding.v1.model.EntitiesOptions;
import com.ibm.watson.natural_language_understanding.v1.model.Features;
import com.ibm.watson.natural_language_understanding.v1.model.KeywordsOptions;

public class IBMService {
	
	public EmotionResult Targetemotion(String text) {
		IamAuthenticator authenticator = new IamAuthenticator("YourIBMAPIKey");
		NaturalLanguageUnderstanding naturalLanguageUnderstanding = new NaturalLanguageUnderstanding("2019-07-12", authenticator);
		naturalLanguageUnderstanding.setServiceUrl("YourIBMUrl");
		
		String usertext = text; 
		
		EmotionOptions emotion= new EmotionOptions.Builder()
		  .build();

		Features features = new Features.Builder()
		  .emotion(emotion)
		  .build();

		AnalyzeOptions parameters = new AnalyzeOptions.Builder()
		  .text(usertext)
		  .features(features)
		  .build();

		AnalysisResults response = naturalLanguageUnderstanding
		  .analyze(parameters)
		  .execute()
		  .getResult();
		
		System.out.println(response);
		
		return response.getEmotion();
	}
	
	public void keyWords() {
		IamAuthenticator authenticator = new IamAuthenticator("sHd3QeMKmYJGDcrDS3GrXq9sd1WkQfuQRR7nvBOjavvk");
		NaturalLanguageUnderstanding naturalLanguageUnderstanding = new NaturalLanguageUnderstanding("2019-07-12", authenticator);
		naturalLanguageUnderstanding.setServiceUrl("https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/3753f012-3a6e-4f75-a0b7-db53689932b8");

		String url = "www.ibm.com";

		KeywordsOptions keywords= new KeywordsOptions.Builder()
		  .sentiment(true)
		  .emotion(true)
		  .limit(3)
		  .build();

		Features features = new Features.Builder()
		  .keywords(keywords)
		  .build();

		AnalyzeOptions parameters = new AnalyzeOptions.Builder()
		  .url(url)
		  .features(features)
		  .build();

		AnalysisResults response = naturalLanguageUnderstanding
		  .analyze(parameters)
		  .execute()
		  .getResult();
		System.out.println(response);
	}
	
	public AnalysisResults textAnalyze(String text){
		IamAuthenticator authenticator = new IamAuthenticator("sHd3QeMKmYJGDcrDS3GrXq9sd1WkQfuQRR7nvBOjavvk");
		NaturalLanguageUnderstanding naturalLanguageUnderstanding = new NaturalLanguageUnderstanding(
		  "2019-07-12", authenticator);
		naturalLanguageUnderstanding.setServiceUrl("https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/3753f012-3a6e-4f75-a0b7-db53689932b8");

		EntitiesOptions entitiesOptions = new EntitiesOptions.Builder()
		  .emotion(true)
		  .sentiment(true)
		  .limit(10)
		  .build();

		KeywordsOptions keywordsOptions = new KeywordsOptions.Builder()
		  .emotion(true)
		  .sentiment(true)
		  .limit(10)
		  .build();
		
		EmotionOptions emotionOptions = new EmotionOptions.Builder()
		  .addTargets(text)
		  .build();
		
		Features features = new Features.Builder()
		  .entities(entitiesOptions)
		  .keywords(keywordsOptions)
		  .emotion(emotionOptions)
		  .build();

		AnalyzeOptions parameters = new AnalyzeOptions.Builder()
		  .text(text)
		  .features(features)
		  .build();

		AnalysisResults response = naturalLanguageUnderstanding
		  .analyze(parameters)
		  .execute()
		  .getResult();
		System.out.println(response);
		
		return response;
	}
}
