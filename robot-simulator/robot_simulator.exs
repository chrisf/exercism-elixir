defmodule RobotSimulator do
  defmodule Robot do
    defstruct position: nil, direction: nil

    @type t :: %Robot{position: atom, direction: {integer, integer}}
  end

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  defguard valid_direction?(direction)
           when direction in [:north, :east, :south, :west]

  defguard valid_position?(position)
           when is_tuple(position) and
                  tuple_size(position) == 2 and
                  is_integer(elem(position, 0)) and
                  is_integer(elem(position, 1))

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _) when not valid_direction?(direction) do
    {:error, "invalid direction"}
  end

  def create(_, position) when not valid_position?(position) do
    {:error, "invalid position"}
  end

  def create(direction, {_, _} = position) do
    %Robot{direction: direction, position: position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: Robot.t(), instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.split(instructions, "", trim: true)
    |> Enum.reduce(robot, &simulate_instruction(&2, &1))
  end

  defguard is_map?(ds)
           when is_map(ds)

  @spec simulate_instruction(Robot.t(), String.t()) :: boolean
  defp simulate_instruction(robot, instruction) when is_map?(robot) do
    case instruction do
      "L" -> turn(robot, "L")
      "R" -> turn(robot, "R")
      "A" -> advance(robot)
      _ -> {:error, "invalid instruction"}
    end
  end

  defp simulate_instruction({:error, "invalid instruction"}, _) do
    {:error, "invalid instruction"}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: Robot.t()) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: Robot.t()) :: {integer, integer}
  def position(robot) do
    robot.position
  end

  defp advance(robot) do
    {x, y} = robot.position

    case robot.direction do
      :north -> %{robot | position: {x, y + 1}}
      :east -> %{robot | position: {x + 1, y}}
      :south -> %{robot | position: {x, y - 1}}
      :west -> %{robot | position: {x - 1, y}}
    end
  end

  defp turn(robot, "L") do
    case robot.direction do
      :north -> %{robot | direction: :west}
      :east -> %{robot | direction: :north}
      :south -> %{robot | direction: :east}
      :west -> %{robot | direction: :south}
    end
  end

  defp turn(robot, "R") do
    case robot.direction do
      :north -> %{robot | direction: :east}
      :east -> %{robot | direction: :south}
      :south -> %{robot | direction: :west}
      :west -> %{robot | direction: :north}
    end
  end
end
