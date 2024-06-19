import SwiftUI

/// Sub view of row content for todo list
struct ListRowView: View {
    /// Binding todo value
    @Binding var todo: Todo
    /// Background colour for .none selection in Todo:Time
    let noneBackgroundColor = Color(white: 0.9)
    
    /// Todo details with checkmark, task text field, and menu with picker to change todo.time
    var body: some View {
        VStack {
            HStack {
                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isDone ? .blue : .gray)
                    .onTapGesture {
                        // Toggle todo check state
                        todo.isDone.toggle()
                    }
                TextField("New task", text: $todo.task)
                    .font(.custom("Futura", size: 17)) // 폰트 설정
                Spacer()
                // Menu selection to change time
                Menu {
                    Picker(selection: $todo.time, label: Text("")) {
                        ForEach(Day.allCases, id: \.self) { value in
                            Text(value.rawValue.capitalized)
                                .tag(value)
                        }
                    }
                } label: {
                    // Label for the menu control
                    Text(todo.time == .none ? "-" : todo.time.rawValue.capitalized)
                        .font(.custom("Futura", size: 17)) // 폰트 설정
                        .foregroundColor(Color.white)
                        .frame(width: 50.0)
                        .background(todo.time == .none ? noneBackgroundColor : .red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
