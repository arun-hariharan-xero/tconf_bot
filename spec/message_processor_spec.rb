require_relative "../Scraper/bot_brains"
require_relative "../Processors/message_processor"
require_relative '../Response/responses'

describe 'MessageProcessor' do 
  before do 
    keywords_json = File.read(File.expand_path("./Dictionaries/keywords_prebuilt.json"))
    @keywords = JSON.parse(keywords_json)
  end 

  let(:brains) { BotBrains.new(@keywords) }
  let(:response) { Responses.new }
  let(:msg_proc) { MessageProcessor.new(@keywords, brains) }

  context '#initialize' do
    it 'initializes with all required values'  do 
      expect(msg_proc.response).to_not be nil
      expect(msg_proc.request).to_not be nil
      expect(msg_proc.fetcher).to_not be nil
    end
  end

  context '#process' do 
    let(:question_list) {
      {
        speakers: 'give me a list of all speakers',
        first_name: 'Norman',
        last_name: 'Clements',
        schedule: 'schedule',
        joke: 'tell me a joke',
        compliment: 'you are awesome',
        wish: 'goodnight',
        love: 'I love you',
        snap: 'shut up',
        lol: 'lol',
        question: 'where',
        question_speaker: 'what is Scott talking about',
        question_bing: 'which high end graphics card should I buy?',
        question_test: 'what sample test',
        question_questions: 'what is your super secret?',
        question_bathroom: 'where is the bathroom?',
        question_exluded: 'what is the drinks menu?',
        bing: 'HTC 10 vs iphone7'
      }
    }

    context 'correctly calls primary cases for' do 
      it 'speakers list based on the input message' do
        expect(msg_proc).to receive(:match_primary_cases).with(question_list[:speakers], "all_speakers_list")
        msg_proc.process(question_list[:speakers])
      end

      it 'Individual List based on the input message for First name' do
        expect(msg_proc).to receive(:match_primary_cases).with(question_list[:first_name], "individual_list")
        msg_proc.process(question_list[:first_name])
      end

      it 'individual_list based on the input message for last name' do
        expect(msg_proc).to receive(:match_primary_cases).with(question_list[:last_name], "individual_list_1")
        msg_proc.process(question_list[:last_name])
      end

      it 'schedule list based on the input message' do
        expect(msg_proc).to receive(:match_primary_cases).with(question_list[:schedule], "schedule_list")
        msg_proc.process(question_list[:schedule])
      end
    end

    context 'correctly calls secondary cases for' do 
      it 'Jokes based on the input message' do
        expect(msg_proc).to receive(:match_secondary_cases).with(question_list[:joke], "joke_init")
        msg_proc.process(question_list[:joke])
      end

      it 'compliment based on the input message' do
        expect(msg_proc).to receive(:match_secondary_cases).with(question_list[:compliment], "compliment")
        msg_proc.process(question_list[:compliment])
      end

      it 'wishes list based on the input message' do
        expect(msg_proc).to receive(:match_secondary_cases).with(question_list[:wish], "wishes")
        msg_proc.process(question_list[:wish])
      end
    end

    context 'correctly calls tertiary cases for' do
       it 'correctly requests bing to produce answer based on the input message' do
        expect(msg_proc).to receive(:match_tertiary_cases).with(question_list[:bing], "Unknown")
        msg_proc.process(question_list[:bing])
      end

      it 'love list based on the input message' do
        expect(msg_proc).to receive(:match_tertiary_cases).with(question_list[:love], "love")
        msg_proc.process(question_list[:love])
      end

      it 'snap list based on the input message' do
        expect(msg_proc).to receive(:match_tertiary_cases).with(question_list[:snap], "snap")
        msg_proc.process(question_list[:snap])
      end

      it 'LOL list based on the input message' do
        expect(msg_proc).to receive(:match_tertiary_cases).with(question_list[:lol], "lol")
        msg_proc.process(question_list[:lol])
      end
    end

    context 'correctly calls faq methods for' do 
      it 'speakers list based on the input message' do
        expect(msg_proc).to receive(:respond_with_correct_faq).with(question_list[:question])
        msg_proc.process(question_list[:question])
      end

      it 'individual speakers list based on the input message' do
        expect(msg_proc).to receive(:respond_with_correct_faq).with(question_list[:question_speaker])
        msg_proc.process(question_list[:question_speaker])
      end

      it 'Bing based on the input message' do
        expect(msg_proc).to receive(:respond_with_correct_faq).with(question_list[:question_bing])
        msg_proc.process(question_list[:question_bing])
      end

      it 'Test Question list based on the input message' do
        expect(msg_proc).to receive(:respond_with_correct_faq).with(question_list[:question_test])
        msg_proc.process(question_list[:question_test])
      end

      it 'Question Questions list based on the input message' do
        expect(msg_proc).to receive(:respond_with_correct_faq).with(question_list[:question_questions])
        msg_proc.process(question_list[:question_questions])
      end

      it 'Question_Bathroom list based on the input message' do
        expect(msg_proc).to receive(:respond_with_correct_faq).with(question_list[:question_bathroom])
        msg_proc.process(question_list[:question_bathroom])
      end

      it 'Unknown Questions list based on the input message' do
        expect(msg_proc).to receive(:respond_with_correct_faq).with(question_list[:question_exluded])
        msg_proc.process(question_list[:question_exluded])
      end

      # I don't particularly enjoy this test - as it is testing the implementation rather than 
      # the behaviour, but this exists anyway and could be extended if I go for Code coverage 
      # in future. 
      it 'should call get speaker hash method from brains' do         
        expect(brains).to receive(:get_speaker_hash)
        allow(brains).to receive(:get_speaker_hash) { ["some Test", "test string"] }
        msg_proc.process(question_list[:speakers])
      end 
    end
  end

  context 'local_testing' do
    it 'will be deleted soon - prints correct answers' do 
      msg_proc.process('what is for lunch?')
    end
  end
end
