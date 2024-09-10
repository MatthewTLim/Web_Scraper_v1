class Spinner
  def initialize(total_steps)
    @spinner = Enumerator.new do |e|
      loop do
        e.yield '|'
        e.yield '/'
        e.yield '-'
        e.yield '\\'
      end
    end
    @total_steps = total_steps
    @current_step = 0
  end

  def spin
    @current_step += 1
    progress = (@current_step.to_f / @total_steps * 100).round(2)
    printf("\rThinking %s Progress: %0.2f%% ", @spinner.next, progress)
    sleep(0.1)
  end

  def spinner_only
    printf("\rThinking %s ", @spinner.next)
    sleep(0.1)
  end
end